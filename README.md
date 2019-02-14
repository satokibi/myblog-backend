# README

## Requirement
- Docker

## Usage

```shell
$ git clone https://github.com/satokibi/myblog-backend.git
$ cd myblog-backend
$ docker-compose up -d --build
$ docker-compose exec web rails db:create
$ docker-compose exec web rails db:migrate
$ docker-compose exec web rails console
```

```terminal
> User.create( name: "admin", mail: "your_mail@address.com", password: "password", admin: true )
> exit
```

http://localhost:3000
