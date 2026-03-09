---
layout: default
title: gomobile
parent: Golang
---

# gomobile

```shell
go get golang.org/x/mobile/cmd/gobind@latest
go get golang.org/x/mobile/cmd/gomobile@latest
go get golang.org/x/mobile/bind
go get  golang.org/x/mobile/bind/objc
```

```go
module github.com/lsongdev/mobile

go 1.24

require (
	golang.org/x/mobile v0.0.0-20250210185054-b38b8813d607 // indirect
	golang.org/x/mod v0.23.0 // indirect
	golang.org/x/sync v0.11.0 // indirect
	golang.org/x/tools v0.30.0 // indirect
)
```

```shell
gomobile init
gomobile bind -target ios,iossimulator,macos -iosversion 15.0 ./xray
```