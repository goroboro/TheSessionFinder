import QtQuick 2.0
import Sailfish.Silica 1.0
import "db.js" as DB

Page {
    id: collectionPage

    Component.onCompleted: {
        console.debug("Load Collection...")
        DB.initialize()
        DB.getCollection()
    }

    function addCollection(id, url, tune, type, key, abc) {
        //console.debug("Adding " + tune)
        collectionModel.append({
                                   id: id,
                                   url: url,
                                   tune: tune,
                                   type: type,
                                   key: key,
                                   abc: abc
                               })
    }

    ListModel {
        id: collectionModel
    }

    SilicaListView {
        id: collectionList
        width: collectionPage.width
        height: collectionPage.height
        header: PageHeader {
            title: "Your Tune Collection"
        }
        anchors.top: parent.top
        model: collectionModel
        ViewPlaceholder {
            enabled: collectionModel.count == 0
            text: qsTr("You have no items in your collection yet. Try searching for a tune and then save it to your collection.")
        }
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Search For Tune"
                onClicked: pageStack.push(Qt.resolvedUrl("Query.qml"))
            }
        }

        VerticalScrollDecorator {
        }

        delegate: Item {
            id: collectionEntry
            property bool menuOpen: contextMenu != null && contextMenu.parent === collectionEntry
            property int myIndex: index
            property Item contextMenu
            width: ListView.view.width
            height: menuOpen ? contextMenu.height + contentItem.height : contentItem.height

            function remove() {
                var removal = removalComponent.createObject(contentItem)
                ListView.remove.connect(removal.deleteAnimation.start)
                removal.execute(contentItem, "Deleting", function () {
                    DB.delCollection(id)
                    collectionModel.remove(index)
                })
            }
            BackgroundItem {
                id: contentItem
                width: parent.width
                onPressAndHold: {
                    if (!contextMenu)
                        contextMenu = contextMenuComponent.createObject(
                                    collectionList)
                    contextMenu.show(collectionEntry)
                }
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("ShowTune.qml"), {
                                       id: id,
                                       tune: tune,
                                       type: type,
                                       abc: abc,
                                       key: key
                                   })
                }

                Label {
                    x: Theme.paddingLarge
                    text: tune + " " + type + " (" + key + ")"
                    anchors.verticalCenter: parent.verticalCenter
                    color: contentItem.down
                           || menuOpen ? Theme.highlightColor : Theme.primaryColor
                }
            }
            Component {
                id: removalComponent
                RemorseItem {
                    property QtObject deleteAnimation: SequentialAnimation {
                                                           PropertyAction {
                                                               target: contentItem
                                                               property: "ListView.delayRemove"
                                                               value: true
                                                           }
                                                           NumberAnimation {
                                                               target: contentItem
                                                               properties: "height,opacity"
                                                               to: 0
                                                               duration: 300
                                                               easing.type: Easing.InOutQuad
                                                           }
                                                           PropertyAction {
                                                               target: contentItem
                                                               property: "ListView.delayRemove"
                                                               value: false
                                                           }
                                                       }
                    onCanceled: destroy()
                }
            }
            Component {
                id: contextMenuComponent
                ContextMenu {
                    id: menu
                    MenuItem {
                        text: "Delete"
                        onClicked: {
                            menu.parent.remove()
                        }
                    }
                }
            }
        }
    }
}
