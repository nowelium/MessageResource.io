MessageResourceTest := UnitTest clone do(
    type := "MessageResourceTest"
    init := method(
        self lang := System getEnvironmentVariable("LANG")
        resend
    )
    setUp := method(
    )
    tearDown := method(
    )
    testGetMessage := method(
        serverStart := HogeMessage SERVER_START {name := "hoge"}
        assertEquals(serverStart, "サーバ hoge が始動しました")
    )

    HogeMessage := MessageResource clone do(
        ja_JP := {
            SERVER_START := "サーバ #{name} が始動しました"
            SERVER_STOP := "サーバ #{name} が停止しました"
        }
    )
)
