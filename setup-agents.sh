#!/bin/bash

TARGET_DIR=".github/agents"
SKILLS_DIR="libs/agentic-skills"

ROOT_DIR=$(pwd)

echo "Configurando agentes no projeto..."

if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo "Pasta $TARGET_DIR criada."
fi

OS_TYPE="$(uname)"
case "$OS_TYPE" in
    "Darwin"|"Linux")
        echo "Detectado macOS ou Linux"
        ln -sf "../../$SKILLS_DIR/.github/agents/architect.agent.md" "$TARGET_DIR/architect.agent.md"
        ln -sf "../../$SKILLS_DIR/.github/agents/implementer.agent.md" "$TARGET_DIR/implementer.agent.md"
        ;;
    "MINGW"*|"MSYS"*|"CYGWIN"*)
        echo "Detectado ambiente Windows (Git Bash/Mingw)"
        
        WIN_ROOT=$(cygpath -w "$ROOT_DIR")

        ARCH_TARGET="$WIN_ROOT\\.github\\agents\\architect.agent.md"
        ARCH_SOURCE="$WIN_ROOT\\libs\\agentic-skills\\.github\\agents\\architect.agent.md"
        
        IMP_TARGET="$WIN_ROOT\\.github\\agents\\implementer.agent.md"
        IMP_SOURCE="$WIN_ROOT\\libs\\agentic-skills\\.github\\agents\\implementer.agent.md"

        powershell.exe -Command "New-Item -ItemType SymbolicLink -Path '$ARCH_TARGET' -Value '$ARCH_SOURCE' -Force"
        powershell.exe -Command "New-Item -ItemType SymbolicLink -Path '$IMP_TARGET' -Value '$IMP_SOURCE' -Force"
        ;;
    *)
        echo "Erro: Sistema operacional nao reconhecido: $OS_TYPE"
        exit 1
        ;;
esac

echo "Configuracao concluida. Verifique os agentes no Copilot Chat."