use regex::Regex;
use std::path::Path;
use std::process::{Command, Output};
use structopt::StructOpt;
use walkdir::{DirEntry, WalkDir};

#[derive(StructOpt, Debug)]
#[structopt(name = "basic")]
enum Opt {
    Get {
        // TODO: -p
        #[structopt(long)]
        shallow: bool,

        #[structopt(long, short = "u")]
        update: bool,

        #[structopt(short = "p")]
        use_ssh: bool,

        #[structopt(name = "repository", parse(try_from_str))]
        repository: String,
    },
    List {
        /// Print full paths (default: false)
        #[structopt(long, short = "p")]
        full_path: bool,

        #[structopt(name = "query", parse(try_from_str))]
        query: Option<String>,
    },
    Root {
        #[structopt(long)]
        all: bool,
    },
}

fn root_dirs() -> Vec<String> {
    let output = Command::new("git")
        .arg("config")
        .arg("--get")
        .arg("ghq.root")
        .output()
        .unwrap();

    // TODO: multiple roots
    let ghq_root = String::from_utf8_lossy(&output.stdout).trim().to_string();
    let mut roots = Vec::new();
    roots.push(ghq_root);
    roots
}

fn local_repo(root: &String, repo: &String) -> String {
    [root, "/github.com/", repo].concat()
}

fn to_print(output: Output) {
    println!(
        "stdout: {}",
        String::from_utf8_lossy(&output.stdout).trim().to_string()
    );

    println!(
        "stderr: {}",
        String::from_utf8_lossy(&output.stderr).trim().to_string()
    );
}

fn main() {
    let opt = Opt::from_args();

    match opt {
        Opt::Root { all } => {
            let ghq_roots = root_dirs();
            if all {
                for root in ghq_roots {
                    println!("{}", root);
                }
            } else {
                println!("{}", ghq_roots[0]);
            }
        }
        Opt::List { full_path, query } => {
            let ghq_roots = root_dirs();
            let mut repos = Vec::<DirEntry>::new();

            let query_cond = match query.as_deref() {
                None => "",
                Some(q) => q,
            };

            for root in &ghq_roots {
                let mut walk_dir = WalkDir::new(root).sort_by_file_name().into_iter();

                loop {
                    let entry = match walk_dir.next() {
                        None => break,
                        Some(Err(err)) => panic!("ERROR: {}", err),
                        Some(Ok(entry)) => entry,
                    };

                    if !query_cond.is_empty() {
                        let local_repo = entry.path().to_str().unwrap();
                        // 全て小文字なら filter by case sensitive
                        if query_cond.to_lowercase().contains(query_cond) {
                            if !local_repo.to_lowercase().contains(query_cond) {
                                continue;
                            }
                        } else {
                            if !local_repo.contains(query_cond) {
                                continue;
                            }
                        }
                    }

                    if !entry.file_type().is_dir() {
                        continue;
                    }

                    if entry.path().join(".git").exists() {
                        repos.push(entry);
                        walk_dir.skip_current_dir();
                    }
                }
            }

            if full_path {
                for repo in repos {
                    println!("{}", repo.path().display());
                }
            } else {
                let root_regex = Regex::new(
                    &ghq_roots
                        .iter()
                        .map(|e| [e, "/"].join(""))
                        .collect::<Vec<_>>()
                        .join("|"),
                )
                .unwrap();

                for repo in repos {
                    println!(
                        "{}",
                        root_regex.replace_all(repo.path().to_str().unwrap(), "")
                    );
                }
            }
        }
        Opt::Get {
            repository,
            shallow,
            use_ssh,
            update,
        } => {
            println!("{} {}", "ghqr get", &repository);

            let roots = root_dirs();

            for root in &roots {
                let path_str = [root, "/github.com/", &repository].concat();
                let cloned = Path::new(&path_str).exists();

                println!("path is {}, existed? is {}", path_str, cloned);
                if cloned {
                    if update {
                        break;
                    }

                    println!("{} is cloned", repository);
                    return;
                }
            }

            let local_repo = local_repo(&roots[0], &repository);
            let cloned = Path::new(&local_repo).exists();

            if !cloned {
                // git clone https_url local_repo
                let mut args = vec!["clone"];

                if shallow {
                    args.push("--depth");
                    args.push("1");
                };

                let url = if repository.starts_with('/') {
                    if !use_ssh {
                        ["https://github.com", &repository].concat()
                    } else {
                        [
                            "git@github.com:",
                            &repository.strip_prefix("/").unwrap(),
                            ".git",
                        ]
                        .concat()
                    }
                } else {
                    if !use_ssh {
                        ["https://github.com/", &repository].concat()
                    } else {
                        ["git@github.com:", &repository, ".git"].concat()
                    }
                };
                println!("url is {}", &url);

                let output = Command::new("git")
                    .args(args)
                    .arg(url)
                    .arg(local_repo)
                    .output()
                    .unwrap();

                to_print(output);
            } else if update {
                let result_of_hash = Command::new("git")
                    .args(vec!["rev-parse", "@{upstream}"])
                    .current_dir(&local_repo)
                    .output();

                match result_of_hash {
                    Ok(output) => to_print(output),
                    Err(error) => {
                        println!("error: {:?}", error);

                        let result_of_fetch = Command::new("git")
                            .args(vec!["fetch"])
                            .current_dir(&local_repo)
                            .output();

                        match result_of_fetch {
                            Ok(output) => to_print(output),
                            Err(error) => {
                                println!("error: {:?}", error);
                                return;
                            }
                        }
                    }
                }

                let result_of_pull = Command::new("git")
                    .args(vec!["pull", "--ff-only"])
                    .current_dir(&local_repo)
                    .output();

                match result_of_pull {
                    Ok(output) => to_print(output),
                    Err(error) => println!("error: {:?}", error),
                }
            }
        }
    }
}
