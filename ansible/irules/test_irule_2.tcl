when HTTP_REQUEST {
    log local0. "irule 2"
    HTTP::redirect https://[HTTP::host][HTTP::uri]
}