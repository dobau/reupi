{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch test package",
            "type": "go",
            "request": "launch",
            "mode": "test",
            "program": "${fileDirname}",
            "envFile": "${workspaceFolder}/.env"
        },
        {
            "name": "Launch debug package",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${workspaceFolder}/cmd/api/main.go",
            "envFile": "${workspaceFolder}/.env"
        }
    ]
}
