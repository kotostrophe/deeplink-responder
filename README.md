
# Deeplink handling example

Example of project how can be easily handled deeplink. Project uses dependency of [CoordinatorKit](https://github.com/kotostrophe/CoordinatorKit) and [DeepCoordinatorKit](https://github.com/kotostrophe/DeepCoordinatorKit). 

Check details of how it works by the links above. 

## Navigation

- [Usage](#usage)
    - [Scheme links](#scheme-links)


## Usage

Use scheme links to test handling mechanism. Scheme links it's just an immitation of deeplinks.

Enter scheme link into your browser and you will be routed to the app.

### Scheme links

Opens list of movies
```url
deep://movies.com/movies
```

Opens movie with identifier `1`. You are able to set any identifier in rage of `1` to `2`, because database is `limited with 2 records`
```url
deep://movies.com/movies/1
```

Opens all the actors who were shooting in movie with identifier `1`
```url
deep://movies.com/movies/1/actors
```

Opens actor with identifier `3`. You can pass any identifier in range of `1` to `5`. It ranged bacause of database is `limited with 5 records`
```url
deep://movies.com/actors/3
```

Opens settings page with identifier. Use `wifi` and `bluetooth` identifiers to open specific settings page
```url
deep://movies.com/settings/<identifier>
```
