#include "TCPServerSocket.hpp"
#include "TCPClientSocket.hpp"

using namespace utility::network::socket;

TCPServerSocket::TCPServerSocket(QObject *parent)
    : QObject(parent)
{
    connect(&m_server, &QTcpServer::newConnection, this, &TCPServerSocket::onNewConnection);
}

TCPServerSocket::~TCPServerSocket()
{

}

bool TCPServerSocket::startServer(int port)
{
    qDebug() << "TCPServerSocket::startServer port:" << port;
    /*
     * brief: QHostAddress::Any
     * - https://doc.qt.io/qt-6/qhostaddress.html#SpecialAddress-enum
    */
    return m_server.listen(QHostAddress::Any, port);
}

void TCPServerSocket::stopServer()
{
    qDebug() << "TCPServerSocket::stopServer";
    m_server.close();
}

void TCPServerSocket::onNewConnection()
{
    qDebug() << "TCPServerSocket::onNewConnection";
    while ( m_server.hasPendingConnections() )
    {
        QTcpSocket *socket = m_server.nextPendingConnection();
        connect(socket, &QTcpSocket::disconnected, this, &TCPServerSocket::onClientDisconnected);
        connect(socket, &QTcpSocket::readyRead, this, &TCPServerSocket::onReadyRead);
        m_clientList.append(socket);
        emit clientConnected(socket);
    }
}

void TCPServerSocket::onClientDisconnected()
{
    qDebug() << "TCPServerSocket::onClientDisconnected";
    QTcpSocket *socket = qobject_cast<QTcpSocket*>(sender());
    if (!socket)
        return;

    m_clientList.removeOne(socket);
    socket->deleteLater();
}

void TCPServerSocket::onReadyRead()
{
    qDebug() << "TCPServerSocket::onReadyRead{";
    QTcpSocket *socket = qobject_cast<QTcpSocket*>(sender());
    if (!socket)
        return;

    QByteArray data = socket->readAll();
    qDebug() << "TCPServerSocket::onReadyRead:{" << data << "}";
}
