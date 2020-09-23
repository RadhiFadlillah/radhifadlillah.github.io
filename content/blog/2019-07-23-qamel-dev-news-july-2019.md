+++
Author = "Radhi Fadlillah"
CreateTime = 2019-07-23T22:14:21+07:00
Tags = ["golang", "qamel"]
Title = "Qamel Development News: July 2019"
+++

Per commit [5015a0][1] I've made several changes to [Qamel][2], QML binding for Go. The changes are intended to make the code more structured and maintainable, therefore there are no changes in end user API. The main changes are :

- Restructure the code following Go project [layout][3]. Because of this, the path for installing Qamel is changed from `github.com/RadhiFadlillah/qamel/qamel` into `github.com/RadhiFadlillah/qamel/cmd/qamel`.
- Implemented `TableModel` and `ListModel` which useful to populate `TableView` and `ListView` in QML using only JSON array.

[1]: https://github.com/RadhiFadlillah/qamel/tree/5015a0b8c3fc1ab2dd824e2a001eb8ea56060223
[2]: https://github.com/RadhiFadlillah/qamel
[3]: https://github.com/golang-standards/project-layout