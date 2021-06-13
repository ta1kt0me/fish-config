function mfa_aws_refresh -d "refresh aws session token"
    printf "MFA Code: "
    read -l code

    if not test -n "$code"
        echo "Enter MFA Code, plz"
        return 1
    end
    aws sts get-caller-identity --query "Arn" --output text | sed -e 's/user/mfa/' | read arn
    echo $arn
    echo $code
    aws --profile default sts get-session-token --serial-number $arn --token-code $code | read -z -l session_token

    echo $session_token | jq -r ".Credentials.Expiration" | read -l expired_at

    if test -z "$expired_at"
        echo "Session Token の取得に失敗しました"
        return 1
    end

    ruby -r active_support/core_ext/time -e "printf \"token is expired at %s\n\", Time.parse(ARGV[0]).in_time_zone('Asia/Tokyo')" $expired_at

    echo $session_token | jq -r ".Credentials.AccessKeyId" | read -l aws_access_key_id
    set -e AWS_ACCESS_KEY_ID
    set -gx AWS_ACCESS_KEY_ID $aws_access_key_id

    echo $session_token | jq -r ".Credentials.SecretAccessKey" | read -l aws_secret_access_key
    set -e AWS_SECRET_ACCESS_KEY
    set -gx AWS_SECRET_ACCESS_KEY $aws_secret_access_key

    echo $session_token | jq -r ".Credentials.SessionToken" | read -l aws_session_token
    set -e AWS_SESSION_TOKEN
    set -gx AWS_SESSION_TOKEN $aws_session_token

    if not test -e ".env"
        return 0
    end

    # session token に意図しない文字列が入るため / 以外の文字を使う
    grep -q 'AWS_ACCESS_KEY_ID=' .env;     and sed -i -e "s~\(AWS_ACCESS_KEY_ID=\).*~\1$aws_access_key_id~" .env;         or sed -i -e "\$aAWS_ACCESS_KEY_ID=$aws_access_key_id" .env
    grep -q 'AWS_SECRET_ACCESS_KEY=' .env; and sed -i -e "s~\(AWS_SECRET_ACCESS_KEY=\).*~\1$aws_secret_access_key~" .env; or sed -i -e "\$aAWS_SECRET_ACCESS_KEY=$aws_secret_access_key" .env
    grep -q 'AWS_SESSION_TOKEN=' .env;     and sed -i -e "s~\(AWS_SESSION_TOKEN=\).*~\1$aws_session_token~" .env;         or sed -i -e "\$aAWS_SESSION_TOKEN=$aws_session_token" .env
end
