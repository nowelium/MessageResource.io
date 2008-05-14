MessageResource := Object clone do (
    init := method(
        replace := Map clone
        replace atPut("-", "")

        self lang := System getEnvironmentVariable("LANG")
        split := lang splitNoEmpties(".")
        self locale := split at(0)
        self encoding := split at(1)
        self encodeName := self encoding replaceMap(replace)
    )
    getMessage := method(messageId, params,
        message := self getSlot(locale) getSlot(messageId)
        message interpolateInPlace(params)
    )
    curlyBrackets := method(
        m := message("as" .. encoding)
        obj := Object clone
        msgString := call message asString 
        message := msgString doMessage(m) asMessage
        message arguments foreach(arg,
            arg setName("setSlot")
            obj doMessage(arg)
        )
        obj
    )
    forward := method(
        m := message("as" .. "self encoding")
        name := call message name
        message := self getSlot(locale) getSlot(name) doMessage(m)
        message container := self
        message curlyBrackets := method(
            obj := call delegateTo(container, call sender)
            self interpolateInPlace(obj)
        )
        message
    )
)
