MessageResource := Object clone do (
    init := method(
        replace := Map clone
        replace atPut("-", "")

        self lang := System getEnvironmentVariable("LANG")
        split := lang splitNoEmpties(".")
        self locale := split at(0)
        self encoding := split at(1)
        self encodeName := self encoding replaceMap(replace)
        self encodingMessage := ("as" .. encoding) asMessage
    )
    getMessage := method(messageId, params,
        message := self getSlot(locale) getSlot(messageId)
        message interpolateInPlace(params)
    )
    curlyBrackets := method(
        obj := Object clone
        call message arguments foreach(arg,
            arg setName("setSlot")
            obj doMessage(arg)
        )
        obj
    )
    forward := method(
        name := call message name
        message := self getSlot(locale) getSlot(name)
        message container := self
        message encodingMessage := self encodingMessage
        message curlyBrackets := method(
            obj := call delegateTo(container, call sender)
            self asMutable doMessage(encodingMessage) interpolateInPlace(obj)
        )
        message
    )
)
