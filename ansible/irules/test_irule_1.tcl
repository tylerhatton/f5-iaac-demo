when HTTP_REQUEST {
    log local0. "irule 1"
    HTTP::redirect https://[HTTP::host][HTTP::uri]
}