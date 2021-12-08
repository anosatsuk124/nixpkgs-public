{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = ''
      set-option -g default-shell "$HOME/.nix-profile/bin/fish"
      bind-key a send-prefix
      # # prefixキーをC-eに変更
      set -g prefix C-q
      # # 
      # # # C-bのキーバインドを解除
      unbind C-b
      
      # ステータスバーをトップに配置する
      set-option -g status-position top
      
      # 左右のステータスバーの長さを決定する 
      set-option -g status-left-length 90
      set-option -g status-right-length 90
      
      # #P => ペイン番号
      # 最左に表示
      set-option -g status-left '#H:[#P]'
      
      # Wi-Fi、バッテリー残量、現在時刻
      # 最右に表示
      set-option -g status-right '#(ssh-host) [%Y-%m-%d(%a) %H:%M]'
      
      # ステータスバーを1秒毎に描画し直す
      set-option -g status-interval 1
      
      # センタライズ（主にウィンドウ番号など）
      set-option -g status-justify centre
      
      # ステータスバーの色を設定する
      set-option -g status-bg "colour238"
      
      # status line の文字色を指定する。
      set-option -g status-fg "colour255"
      
      # vimのキーバインドでペインを移動する
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # vimのキーバインドでペインをリサイズする
      bind -n C-H resize-pane -L 5
      bind -n C-J resize-pane -D 5
      bind -n C-K resize-pane -U 5
      bind -n C-L resize-pane -R 5
      
      bind c new-window -c '#{pane_current_path}'
      
      # | でペインを縦分割する
      bind v split-window -h -c '#{pane_current_path}'
      
      # - でペインを縦分割する
      bind s split-window -v -c '#{pane_current_path}'
      
      # 番号基準値を変更
      set-option -g base-index 1
      
      # マウス操作を有効にする
      set-option -g mouse on
      bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
      
      # コピーモードを設定する
      # コピーモードでvimキーバインドを使う
      setw -g mode-keys vi
      
      # unbind [
      # bind @ copy-mode
      
      # 'v' で選択を始める
      bind -T copy-mode-vi v send -X begin-selection
      
      # 'V' で行選択
      bind -T copy-mode-vi V send -X select-line
      
      # 'C-v' で矩形選択
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      
      # 'y' でヤンク
      bind -T copy-mode-vi y send -X copy-selection
      
      # 'Y' で行ヤンク
      bind -T copy-mode-vi Y send -X copy-line
      
      # 'C-p'でペースト
      # bind -n C-p paste-buffer
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -b > /dev/null"
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xsel -b > /dev/null"
      
      #===================================
      # tpm - Tmux Plugin Manager
      #===================================
      
      # Plugins
      set -g @plugin 'tmux-plugins/tpm'
      
      # Initialize TMUX plugin manager 
      # (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'
      
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
      
      set -g @plugin 'yuuan/tmux-ssh-host'
    '';
  };
}
