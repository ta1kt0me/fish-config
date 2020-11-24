 # TODO: direnv っぽい感じでやる
function ssm_start -d "start ssm session in selected instance filtered by Env tag, Usage: ssm_start env"
    set -l environment $argv[1]

    if test -z $environment
        echo 第一引数に Env を指定してください
        return 1
    end

    aws ec2 describe-instances \
        --filter "Name=tag:Env,Values=$environment" \
        --query 'Reservations[].Instances[].{ID:InstanceId,TagEnv:[Tags[?Key==`Env`].Value][0][0],TagName:[Tags[?Key==`Name`].Value][0][0]}' \
        --output text | peco | cut -f 1 | read -l id

    if test $status -ne 0
        echo SESSION TOKEN を更新してください
        return 1
    end

    aws ssm start-session --target $id
end
