import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    property string queryString
    XmlListModel {
        id: results
        source: "http://thesession.org/tunes/search?type=&mode=&format=xml&q=" + queryString
        query: "/document/tunes/tune"
        XmlRole {
            name: "name"
            query: "name/string()"
        }
        XmlRole {
            name: "url"
            query: "url/string()"
        }
        XmlRole {
            name: "type"
            query: "type/string()"
        }
    }
    id: page
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Return To Collection"
                onClicked: {
                    pageStack.clear()
                    pageStack.push('CollectionPage.qml')
                }
            }
        }


        SilicaListView {
            id: listView
            model: results
            anchors.fill: parent
            header: PageHeader {
                title: "Search Results"
            }
            delegate: BackgroundItem {
                id: delegate
                Label {
                    x: Theme.paddingLarge
                    text: name + ' (' + type + ')'
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                property string infoUrl: url + "?format=xml"
                onClicked: pageStack.push(Qt.resolvedUrl("TuneInfo.qml"), {
                                              infoUrl: infoUrl,
                                              tune: name,
                                              type: type
                                          })
            }
            VerticalScrollDecorator {
            }
        }
    }
}
