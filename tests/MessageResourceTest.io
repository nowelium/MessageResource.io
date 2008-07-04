MessageResourceTest := UnitTest clone do(
    type := "MessageResourceTest"
    init := method(
    )
    setUp := method(
    )
    tearDown := method(
    )
    testGetMessage := method(
        serverStart := HogeMessage SERVER_START {name := "hoge"}
        assertEquals(serverStart, "サーバ hoge が始動しました" asUTF8)
    )

    HogeMessage := MessageResource clone do(
        ja_JP := {
            SERVER_START := "サーバ #{name} が始動しました",
            SERVER_STOP := "サーバ #{name} が停止しました"
        }
        C := {
            SERVER_START := "server #{name} has started",
            SERVER_STOP :=  "server #{name} has stopped"
        }
    )
)
