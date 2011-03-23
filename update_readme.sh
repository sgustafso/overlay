grep '^\*\*\*' -B9999 README > README.new
mv README.new README
find -mindepth 2 -maxdepth 2 -type d | grep -v '\.git' | sort | sed 's/^.\///' >> README
