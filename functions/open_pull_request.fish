function open_pull_request -d "open pull request via current branch"
    curl -s (hub browse -u | sed -e 's/github\.com/api.github.com\/repos/' -e 's/\/tree\/.*//')/pulls\?head\=grooves:(git rev-parse --abbrev-ref HEAD)\&access_token\=$GITHUB_API_TOKEN | jq .[].html_url | xargs open
end
