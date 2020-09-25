// Namespace definition
Ext.ns("SYNOCOMMUNITY.sl");

// Application definition
Ext.define("SYNOCOMMUNITY.sl.AppInstance", {
    extend : "SYNO.SDS.AppInstance",
    appWindowName : "SYNOCOMMUNITY.sl.AppWindow",
    constructor : function() {
        this.callParent(arguments)
    }
});

// Window definition
Ext.define("SYNOCOMMUNITY.sl.AppWindow", {
    extend : "SYNO.SDS.AppWindow",

    // Nombre de lignes maximum dans les tableaux (pour la pagination)
    maxItem: 50,

    // Liste des onglets
    tabs: null,

    // Tableau contenant les recettes
    recipes: null,

    //Tableau contenant les magasines
    magazines: null,

    // Tableau contenant les recettes
    editeurs: null,

    //Tableau contenant les magasines
    genres: null,

    // Tableau contenant les recettes
    types: null,

    //Tableau contenant les magasines
    personnes: null,

    // Tableau contenant les recettes
    series: null,

    //Tableau contenant les magasines
    tomes: null,

    constructor : function(config) {
        var me = this;

        me.recipes = me.createGrid("recipes");
        me.magazines = me.createGrid("magazines");

        me.recipes = me.createGrid("editeurs");
        me.magazines = me.createGrid("genres");

        me.recipes = me.createGrid("types");
        me.magazines = me.createGrid("personnes");

        me.recipes = me.createGrid("series");
        me.magazines = me.createGrid("tomes");

        me.tabs = (function () {
            var allTabs = [];

            // Liste des magazines
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "magazine"),
                layout: "fit",
                items: me.magazines
            });

            // Liste des recettes
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "recipe"),
                layout: "fit",
                items: me.recipes
            });

            // Liste des editeur
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "editeur"),
                layout: "fit",
                items: me.editeurs
            });

            // Liste des genres
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "genre"),
                layout: "fit",
                items: me.genres
            });

            // Liste des types
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "type"),
                layout: "fit",
                items: me.types
            });

            // Liste des personnes
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "personne"),
                layout: "fit",
                items: me.personnes
            });

            // Liste des series
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "serie"),
                layout: "fit",
                items: me.series
            });

            // Liste des tomes
            allTabs.push({
                title: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "tome"),
                layout: "fit",
                items: me.tomes
            });

            return allTabs;
        }).call(me);
        
        config = Ext.apply({
            resizable : true,
            maximizable : true,
            minimizable : true,
            width : 800,
            height : 480,
            layout: "fit",
            items : [ {
                xtype: "syno_tabpanel",
                activeTab: 0,
                plain: true,
                items: me.tabs,
                deferredRender: true
            } ],
            buttons: [{
                xtype: "syno_button",
                text: _T("common", "close"),
                scope: me,
                handler: function () {
                    me.close();
                }
            }]
        }, config);

        this.callParent([ config ]);
    },
    
    createFilter: function (gridStore) {
        var me = this;

        var searchField = new SYNO.ux.TextFilter({
            emptyText: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "search"),
            store: gridStore,
            pageSize: me.maxItem,
            width: 300
        });

        var toolbar = new SYNO.ux.Toolbar({
            items: [ searchField ]
        });

        return toolbar;
    },
    
    createPaging: function (gridStore) {
        var me = this;

        var toolbar = new SYNO.ux.PagingToolbar({
            store: gridStore,
            displayInfo: true,
            pageSize: me.maxItem,
            refreshText: _T("log", "log_reload")
        });

        return toolbar;
    },
    
    createGrid: function(dataSrc) {
        var me = this;
        var localUrl = "/webapi/mangatheque/mangatheque.cgi?list=" + dataSrc;

        // Définition du store pour récupérer l'ensemble des éléments
        var gridStore = new SYNO.API.JsonStore({
            autoDestroy: true,
            url : localUrl,
            restful: true,
            root: 'result',
            idProperty: 'identifier',
            fields: [{
                name: 'identifier',
                type: 'int'
            }, {
                name: 'title',
                type: 'string'
            }, {
                name: 'description',
                type: 'string'
            }]
        });

        var paging = me.createPaging(gridStore);

        var c = {
            store: gridStore,
            colModel: new Ext.grid.ColumnModel({
                defaults: {
                    sortable: true,
                    menuDisabled: true,
                    width: 100,
                    height: 20
                },
                columns: [{
                    header: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "identifier"),
                    width: 75,
                    dataIndex: "identifier"
                }, {
                    header: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "title"),
                    width: 100,
                    dataIndex: "title"
                }, {
                    header: _TT("SYNOCOMMUNITY.sl.AppInstance", "body", "description"),
                    width: 75,
                    dataIndex: "description"
                }]
            }),
            viewConfig: {
                forceFit: true,
                onLoad: Ext.emptyFn,
                listeners: {
                    beforerefresh: function (f) {
                        f.scrollTop = f.scroller.dom.scrollTop;
                    },
                    refresh: function (f) {
                        f.scroller.dom.scrollTop = f.scrollTop;
                    }
                }
            },
            columnLines: true,
            frame: false,
            tbar: me.createFilter(gridStore),
            bbar: paging,
            cls: "resource-monitor-performance",
            refresh: paging.doRefresh.createDelegate(paging),
            listeners: {
                scope: me,
                render: function (grid) {
                    grid.getStore().load({
                        params: {
                            offset: 0,
                            limit: me.maxItem
                        }
                    });
                }
            }
        };

        return new SYNO.ux.GridPanel(c);
    }
});
