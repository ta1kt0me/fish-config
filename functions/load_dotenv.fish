function load_dotenv -d "load .env into global variables"
    if not test -e ".env"
        return 1
    end

    # `A=B` -> `set -gx A B`
    ruby -e 'puts $stdin.read.split("\n").reject { |l| l.match?(/\A# /) }.map { |l| l.sub("=", " ").prepend("set -gx ") }' < .env | source
end
