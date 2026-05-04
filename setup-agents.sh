#!/bin/bash

# Caminhos base
TARGET_DIR=".github/agents"
SKILLS_DIR="libs/agentic-skills"

echo "Configurando agentes no projeto..."

# Garante que a pasta de destino exista
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo "Pasta $TARGET_DIR criada."
fi

# Detecta o Sistema Operacional
OS_TYPE="$(uname)"
case "$OS_TYPE" in
    "Darwin"|"Linux")
        echo "Detectado macOS ou Linux"
        ln -sf "../../$SKILLS_DIR/.github/agents/architect.agent.md" "$TARGET_DIR/architect.agent.md"
        ln -sf "../../$SKILLS_DIR/.github/agents/implementer.agent.md" "$TARGET_DIR/implementer.agent.md"
        ;;
    "MINGW"*|"MSYS"*|"CYGWIN"*)
        echo "Detectado ambiente Windows (Git Bash/Mingw)"
        # No Windows, usamos o PowerShell via terminal para garantir a criação do Link Simbólico
        powershell.exe -Command "New-Item -ItemType SymbolicLink -Path '$TARGET_DIR\architect.agent.md' -Value '..\..\$SKILLS_DIR\.github\agents\architect.agent.md' -Force"
        powershell.exe -Command "New-Item -ItemType SymbolicLink -Path '$TARGET_DIR\implementer.agent.md' -Value '..\..\$SKILLS_DIR\.github\agents\implementer.agent.md' -Force"
        ;;
    *)
        echo "Erro: Sistema operacional nao reconhecido: $OS_TYPE"
        exit 1
        ;;
esac

echo "Configuracao concluida. Verifique os agentes no Copilot Chat."