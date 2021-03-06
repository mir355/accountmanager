/**
 * Account Manager System (https://github.com/PsyduckMans/accountmanager)
 *
 * @link      https://github.com/PsyduckMans/accountmanager for the canonical source repository
 * @copyright Copyright (c) 2014 PsyduckMans (https://ninth.not-bad.org)
 * @license   https://github.com/PsyduckMans/accountmanager/blob/master/LICENSE MIT
 * @author    Psyduck.Mans
 */

Ext.define('AccountManager.view.resource.resourceAccount.EditView', {
    extend: 'Ext.window.Window',
    alias: 'widget.resourceaccounteditview',

    constrain: true,
    hideMode: 'offsets',
    closeAction: 'hide',
    resizable: false,
    title: '',
    width: 400,
    height: 155,
    modal: true,

    id: 'resourceAccountEditView',

    initComponent: function() {
        var me = this;

        me.form = Ext.create('Ext.form.Panel', {
            border: false,
            bodyPadding: 5,
            bodyStyle: 'background:#DFE9F6',
            trackResetOnLoad: true,
            waitTitle: '请等待...',
            api: {
                submit: AccountManager.Direct.Resource.accountAdd
            },
            fieldDefaults: {
                labelWidth: 65,
                labelSeparator: ':',
                anchor: '0'
            },
            items: [
                {
                    xtype: 'textfield',
                    fieldLabel: '资源Id',
                    name: 'ResourceId',
                    readOnly: true,
                    readOnlyCls: 'x-item-disabled'
                },
                {
                    xtype: 'textfield',
                    fieldLabel: '账户名',
                    name: 'Identity',
                    allowBlank: false,
                    maxLength: 255
                },
                {
                    xtype: 'combo',
                    fieldLabel: '账号标识',
                    store: 'AccountCombo',
                    name: 'AccountId',
                    displayField: 'Identifier',
                    valueField: 'Id',
                    allowBlank: false,
                    queryParam: 'q',
                    queryMode: 'remote',
                    minChars:0,
                    triggerAction: 'all',
                    pageSize: 15
                }
            ],

            dockedItems: [
                {
                    xtype: 'toolbar',
                    dock: 'bottom',
                    ui: 'footer',
                    layout: {pack: 'center'},
                    items: [
                        {
                            text: '保存',
                            disabled: true,
                            formBind: true,
                            handler: me.doSave,
                            scope: me
                        },
                        {
                            text: '重置',
                            handler: me.doReset,
                            scope: me
                        }
                    ]
                }
            ]
        });

        me.items = [me.form];
        me.callParent(arguments);
    },

    initEvent: function() {
        this.on('show', this.focusField);
    },

    forcusField: function() {
        var f = this.form.getForm();
        f.findField('Name').focus();
    },

    doSave: function() {
        var me = this,
            f = me.form.getForm();
        if(f.isValid() && f.isDirty()) {
            f.submit({
                waitMsg: '正在关联...',
                success: function(form, action) {
                    var me = this,
                        result = action.result,
                        f = me.form.getForm(),
                        store = Ext.StoreManager.lookup('ResourceAccount'),
                        rec = f.getRecord();
                    f.updateRecord(rec);
                    if(form.actionMethod == 'accountAssociate') {
                        rec.set('ResourceId', result.data.ResourceId);
                        rec.set('CategoryId', result.data.CategoryId);
                        rec.set('Identifier', result.data.Identifier);
                        rec.set('Password', result.data.Password);
                        rec.set('CreateTime', result.data.CreateTime);
                        store.insert(0, rec);
                    }
                    rec.commit();
                    me.close();
                    // clear form
                    m = store.model;
                    f.loadRecord(new m());
                },
                failure: function(form, action) {
                    if(action.failureType === 'connect') {
                        Ext.Msg.alert('错误', '状态:'+action.respons.status+','+action.respons.statusText);
                        return ;
                    }
                    if(action.failureType === 'server') {
                        Ext.Msg.alert('错误', action.result.msg);
                    }
                },
                scope: me
            });
        } else {
            Ext.Msg.alert('修改', '请修改数据后再提交.');
        }
    },

    doReset: function() {
        this.form.getForm().reset();
    }
});