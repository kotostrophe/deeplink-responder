
# Deeplink handling example

## Usage

Use scheme links to test handling mechanism. Enter scheme link into your browser

### Scheme links

Opens list of movies
```http
deep://movies.com/movies
```

Opens movie with identifier `1`. You are able to set any identifier in rage of `1` to `2`, because database is `limited with 2 records`
```http
deep://movies.com/movies/1
```

Opens all the actors who were shooting in movie with identifier `1`
```http
deep://movies.com/movies/1/actors
```

Opens actor with identifier `3`. You can pass any identifier in range of `1` to `5`. It ranged bacause of database is `limited with 5 records`
```http
deep://movies.com/actors/3
```

Opens settings page with identifier. Use `wifi` and `bluetooth` identifiers to open specific settings page
```http
deep://movies.com/settings/<identifier>
```
