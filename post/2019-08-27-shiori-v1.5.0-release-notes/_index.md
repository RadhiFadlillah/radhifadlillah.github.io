+++
Title = "Shiori v1.5.0 Release Notes"
Excerpt = ""
CreatedAt = "2019-08-27 15:25:04 +0700"
UpdatedAt = "2019-08-27 15:25:04 +0700"
Category = "shiori"
Tags = ["shiori", "news"]
Author = "Radhi Fadlillah"
+++

Today Shiori v1.5.0 is released after almost 4 [months](https://github.com/go-shiori/shiori/commit/f582fd15525e26f7fbbeb9cd776182f1819dc146) of development (with several long breaks between). This release is quite huge with many changes and improvement from older version. Granted there are still some rough edges, but I think it's still usable enough to release. 

![Screenshot](screenshot.png)

Since there are many changes, I will split it into two parts, the back-end and front-end.

## Back-End

- Use Go modules. Thanks to this, we don't need to use Git submodules anymore to include `go-readability`.
- Restructure code following [Go Project Layout](https://github.com/golang-standards/project-layout).
- Huge update in [`go-readability`](https://github.com/go-shiori/go-readability). Now it closely follows code in Readability.js, which means it now as accurate as Firefox reader mode.
- Removed `account` command. Before, on fresh install, to access web interface we need to manually register account. This is quite annoying, especially if we are using Docker. Now, on fresh install, we can just login using default password and account (`shiori` with password `gopher`).
- Replace JWT with simple session for login. Before, if an account already login then admin removed that account, the account can still access the web interface as long its JWT key is still valid. Now, thanks to session, if an account got removed we can do mass log out for that account.
- Use favicon as alternative if hero image doesn't exists.
- Resized thumbnail image to 4:3 aspect ratio. This is done to make all image looks consistent. If the thumbnail image doesn't have that ratio, it will be padded by color that matches with the image.
- Add support for MySQL database ([#81](https://github.com/go-shiori/shiori/issues/81), thanks to [@peteretelej](https://github.com/peteretelej) for the groundwork).
- Add initial support for archiving the entire web page. Before, Shiori only saves the output of `go-readability`, which sometimes not really good (for example is, Stack Overflow). Now, when requested, Shiori will archive the web page with its entire resource.
- When a bookmark is archived, the reader mode will uses images and other resources from the archive instead of the one from original site ([#108](https://github.com/go-shiori/shiori/issues/108)).
- Add support for bookmarking non HTML URL ([#77](https://github.com/go-shiori/shiori/issues/77)).
- Add support for bookmarking non reachable URL ([#128](https://github.com/go-shiori/shiori/issues/112)).
- Fix failed to delete many bookmarks at once ([#104](https://github.com/go-shiori/shiori/issues/104)).
- Add option to specify address and port number while serving web interface ([#101](https://github.com/go-shiori/shiori/issues/101), thanks to [@contradictioned](https://github.com/contradictioned)).
- Add portable mode ([#126](https://github.com/go-shiori/shiori/issues/126)).
- Set user agent for downloading and archiving an URL ([#127](https://github.com/go-shiori/shiori/issues/127)).
- Add support for searching in bookmark's excerpt ([#134](https://github.com/go-shiori/shiori/issues/134)).
- Other minor improvements in CLI, which I forgot the detail.

## Front-End

- Use ES6 feature like modules and arrow function. Thanks to modules, I can (kind of) imitate the Vue's single file component without using JS bundler.
- Use `fetch` instead of third party library like `axios`.
- Increase font size to make it more readable.
- Move actions from sidebar to header.
- Revamped the mobile view.
- Revamped options page and add account management.
- Uses history state so back and forward button works properly. Thanks to this, now search result can be shared via its URL ([#111](https://github.com/go-shiori/shiori/issues/111)).
- Add icons which shows if bookmark has archive or readable content.
- In list mode, make layout tighter to give space for more visible content.
- Now bookmarks is sorted by last created instead of last modified.
- Add initial support for [web extension](https://github.com/go-shiori/shiori-web-ext) to replace bookmarklet.
- In Firefox for Android, make the address bar gone while scrolling.
- Display creation and modified time in local timezone instead of UTC ([#103](https://github.com/go-shiori/shiori/issues/103)).
- Make Vue.js doesn't uses development mode in production ([#106](https://github.com/go-shiori/shiori/issues/106)).
- Add `rel=noopener` on link that open in new tab ([#105](https://github.com/go-shiori/shiori/issues/105), thanks to [@sascha-andres](https://github.com/sascha-andres)).
- Group bookmarks that tagged or untagged ([#109](https://github.com/go-shiori/shiori/issues/109)).
- Add support to flag whether a bookmark is public or private ([#112](https://github.com/go-shiori/shiori/issues/112)).
- Add support for account's level. Now, we can specify whether an account is the owner (i.e. can add and edit data) or only a visitor (i.e can only read the data) ([#137](https://github.com/go-shiori/shiori/issues/137)).
- Add tag's auto completion in edit dialog ([#135](https://github.com/go-shiori/shiori/issues/135)).
- Add menu to rename the existing tags ([#136](https://github.com/go-shiori/shiori/issues/136)).

## Future Plans

There are still several issues and feature that I want to be implemented in the future :

- If you look at the source code, you will realize that there are no unit tests. None, at all.
- There are some codes that repeated multiple times. For example is the code that used to download web page which repeated in `cmd` and `webserver` package.
- Some feature is available in web interface but not in CLI. For example: renaming tags and flagging a bookmark as private or public.
- I haven't extensively tested the import feature. The issues about importing bookmarks ([#121](https://github.com/go-shiori/shiori/issues/121), [#125](https://github.com/go-shiori/shiori/issues/135)) mention that they have a lot of bookmarks to import. Meanwhile my bookmarks at most only has several hundred entries which is not near enough to what they have. Thanks to this, I haven't been able to reprouce their issues. If any of you willing to submit your bookmarks, feels free to email me.

Unfortunately, the development process might be as slow as before. For financial reasons, I'm started looking for additional jobs to increase my funds, which means less time for Shiori. However, when I got the time I will try to work on these issues. And, as usual, if you like this project please consider donating to me either via [PayPal](https://www.paypal.me/RadhiFadlillah) or [Ko-Fi](https://ko-fi.com/radhifadlillah).
