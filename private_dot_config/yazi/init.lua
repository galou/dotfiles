-- Config for https://github.com/dedukun/bookmarks.yazi.
-- (`ya pack -a dedukun/bookmarks`)
require("bookmarks"):setup({
	save_last_directory = false,
	persist = "all",
	desc_format = "parent",
	notify = {
		enable = true,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})
