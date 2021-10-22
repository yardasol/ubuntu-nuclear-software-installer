set -o errtrace
# Check input exists

if [[ ! -d "$1" ]]; then
	cd $1 || "ERROR: $1 does not exist" && exit 100
fi

echo "hahA"
