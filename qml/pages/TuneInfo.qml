import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    property string infoUrl
    property string tune
    property string type
    XmlListModel {
        id: tuneSettings
        source: infoUrl
        query: "/document/settings/setting"
        XmlRole {
            name: "id"
            query: "id/string()"
        }
        XmlRole {
            name: "key"
            query: "key/string()"
        }
        XmlRole {
            name: "abc"
            query: "abc/string()"
        }
    }
    id: page

    SilicaListView {
        id: listView
        model: tuneSettings
        width: page.width
        height: page.height
        anchors.top: parent.top
        header: PageHeader {
            title: "Tune Settings"
        }
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Return To Collection"
                onClicked: {
                    pageStack.clear()
                    pageStack.push('CollectionPage.qml')
                }
            }
            MenuItem {
                text: "Search For Tune"
                onClicked: pageStack.replace(Qt.resolvedUrl("Query.qml"))
            }
        }
        delegate: BackgroundItem {
            id: delegate
            Label {
                x: Theme.paddingLarge
                text: '(' + id + ') ' + key
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: pageStack.push(Qt.resolvedUrl("ShowTune.qml"), {
                                          url: infoUrl,
                                          id: id,
                                          tune: tune,
                                          type: type,
                                          abc: abc,
                                          key: key
                                      })
        }
        VerticalScrollDecorator {
        }
    }
}

