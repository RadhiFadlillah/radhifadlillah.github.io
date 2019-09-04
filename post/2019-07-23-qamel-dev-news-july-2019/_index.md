+++
Title = "Qamel Development News: July 2019"
Excerpt = ""
CreatedAt = "2019-07-23 22:14:21 +0700"
UpdatedAt = "2019-07-23 22:14:21 +0700"
Category = "qamel"
Tags = ["qamel", "news", "gui", "go", "golang"]
Author = "Radhi Fadlillah"
+++

Per commit [5015a0](https://github.com/RadhiFadlillah/qamel/tree/5015a0b8c3fc1ab2dd824e2a001eb8ea56060223) I've made several changes to [Qamel](https://github.com/RadhiFadlillah/qamel), QML binding for Go. The changes are intended to make the code more structured and maintainable, therefore there are no changes in end user API. The main changes are :

- Restructure the code following Go project [layout](https://github.com/golang-standards/project-layout). Because of this, the path for installing Qamel is changed from `github.com/RadhiFadlillah/qamel/qamel` into `github.com/RadhiFadlillah/qamel/cmd/qamel`.
- Implemented `TableModel` and `ListModel` which useful to populate `TableView` and `ListView` in QML using only JSON array.
