# Run tests inside container.
command=$(cat <<-END
mkdir --parents "/tmp/php-curl-class" &&
rsync --delete --exclude=".git" --exclude="vendor" --links --recursive "/data/" "/tmp/php-curl-class/" &&
cd "/tmp/php-curl-class" &&
export TRAVIS_PHP_VERSION="7.0" &&
(
    [ ! -f "/tmp/.composer_updated" ] &&
    composer --no-interaction update &&
    touch "/tmp/.composer_updated" ||
    exit 0
) &&
bash "tests/before_script.sh" &&
bash "tests/script.sh"
END
)
set -x
docker exec --interactive --tty "php70" sh -c "${command}"
