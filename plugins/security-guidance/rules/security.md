## Security guidance (baseline)

Перед применением изменений проверяй:

- command injection: shell вызовы, `exec`, непроверенные аргументы
- XSS: `innerHTML`, `dangerouslySetInnerHTML`, HTML шаблоны без экранирования
- SSRF: fetch/requests на user-controlled URL
- deserialization: `pickle`, `yaml.load`, небезопасные декодеры
- secrets: ключи/токены в репо, логи, трейсах
- authz: проверки прав (не только authn)
- path traversal: файловые пути из user input
