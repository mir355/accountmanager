Ext.define('AccountManager.view.MainMenu', {
    extend: 'Ext.toolbar.Toolbar',
    alias: 'widget.mainmenu',

    id: 'mainmenu',

    initComponent: function() {
        var me = this;

        userInfo = Ext.state.Manager.get('userInfo');
        buttons = [];

        buttons.push({text:'账号管理', action:'account'});
        buttons.push({text:'密码管理', action:'password'});
        if(userInfo.role=='管理员') {
            buttons.push({text:'用户管理', action:'user'});
        }

        buttons.push('->');
        buttons.push({text:'退出', action:'quit'});

        me.items = buttons;

        this.callParent(arguments);
    }
});