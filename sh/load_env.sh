export $(grep -v '^#' .env | xargs -d '\n')

# mac / bsd
export $(grep -v '^#' .env | xargs -0)
