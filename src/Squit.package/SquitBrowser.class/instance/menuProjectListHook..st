ui menu
menuProjectListHook: aMenu
	<menuProjectList>
	aMenu addList: {
		{'Add project'. #actionProjectAdd}.
		{'Clone project'. #actionProjectClone}.
		{'Rename project'. #actionProjectRename}.
		{'Remove project'. #actionProjectRemove}.
	}.
	aMenu addLine.
	aMenu addList: {
		{'Change tracked packages'. #actionChooseTrackedPackages. 'Add or remove packages for this project.'}
	}.
	aMenu addLine.
	aMenu addList: {
		{'Add remote'. #actionRemoteAdd}.
		{'Remove remote'. #actionRemoteRemove}
	}.
	aMenu addLine.
	aMenu addList: {
		{'Edit credentials for project'. #actionCredentialsEdit}.
		{'Edit project-level git user name/email'. #actionGitUserEdit}
	}.
	aMenu addLine.
	aMenu addList: {
		{'Explore SquotWorkingCopy'. #actionSquotWorkingCopyExplore}.
	}.
	^ aMenu