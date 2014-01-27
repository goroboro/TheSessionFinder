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
        console.debug("Adding " + tune)
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


    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Search For Tune"
                onClicked: pageStack.push(Qt.resolvedUrl("Query.qml"))
            }
        }

        SilicaListView {
            id: collectionList

            header: PageHeader {
                title: "The Session Tune Finder"
            }
            anchors.fill: parent
            model: collectionModel
            delegate: BackgroundItem {
                id: collectionEntry
                Label {
                    x: Theme.paddingLarge
                    text: tune + " " + type + " (" + key + ")"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    color: collectionEntry.highlighted ? Theme.highlightColor : Theme.primaryColor
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
            }
            VerticalScrollDecorator {
            }
        }
    }
}
