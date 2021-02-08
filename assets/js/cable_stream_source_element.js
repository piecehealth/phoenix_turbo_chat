import { connectStreamSource, disconnectStreamSource } from "@hotwired/turbo"
import socket from "./socket"

class TurboCableStreamSourceElement extends HTMLElement {
  connectedCallback() {
    connectStreamSource(this)
    const channelName = this.getAttribute("channel")
    const sign = this.getAttribute("signed-stream-name")
    this.channel = socket.channel(`turbo-streams:${channelName}`, { sign })
    this.channel.join()
    this.channel.on("update_stream", ({ data }) => {
      this.dispatchMessageEvent(data)
    })
  }

  disconnectedCallback() {
    disconnectStreamSource(this)
    if (this.channel) this.channel.leave()
  }

  dispatchMessageEvent(data) {
    const event = new MessageEvent("message", { data })
    return this.dispatchEvent(event)
  }
}

customElements.define("turbo-cable-stream-source", TurboCableStreamSourceElement)
