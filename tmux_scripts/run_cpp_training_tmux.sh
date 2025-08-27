#!/bin/bash

SESSION="cpp-training"
PROJECT_PATH="$HOME/Desktop/repos/personal/mycpp"

if tmux has-session -t $SESSION 2>/dev/null; then
    echo "Session '$SESSION' exists. Attaching..."
    tmux attach-session -t $SESSION
else
    echo "Creating new session '$SESSION'..."
    # Create new session
    tmux new-session -d -s $SESSION -c $PROJECT_PATH
    tmux rename-window -t $SESSION:1 'editor'
    tmux send-keys -t $SESSION:1 'nvim .' Enter
    tmux new-window -t $SESSION -c $PROJECT_PATH -n 'terminal'
    tmux new-window -t $SESSION -c $PROJECT_PATH -n 'claude'
    tmux send-keys -t $SESSION:3 'claude' Enter
    tmux select-window -t $SESSION:1
    tmux attach-session -t $SESSION
fi
