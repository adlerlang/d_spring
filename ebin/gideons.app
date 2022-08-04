{application, 'gideons', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{id, ""},
	{modules, ['gid_http','gid_utils','gideons_app','gideons_sup']},
	{registered, [gideons_sup]},
	{applications, [kernel,stdlib]},
	{mod, {gideons_app, []}},
	{env, []}
]}.