import os

from ptpython.repl import PythonRepl
from ptpython.layout import CompletionVisualisation

__all__ = ['configure']


def configure(repl: PythonRepl):
    """
    Configuration method. This is called during the start-up of ptpython.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    # repl.show_docstring = False

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    # repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    # repl.show_line_numbers = False

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parentheses.
    repl.highlight_matching_parenthesis = True

    # Mouse support.
    repl.enable_mouse_support = True

    # Fuzzy and dictionary completion.
    repl.enable_fuzzy_completion = True
    repl.enable_dictionary_completion = True

    # Enable the modal cursor (when using Vi mode). Other options are 'Block', 'Underline',  'Beam',  'Blink under', 'Blink block', and 'Blink beam'
    repl.cursor_shape_config = 'Beam'

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = True

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = 'ipython'  # 'classic' or 'ipython'

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = False

    # Enable open-in-editor. Pressing C-x C-e in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Editor
    os.environ |= {
        'VISUAL': 'code -w',
        'EDITOR': 'msedit',
    }

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Use this colorscheme for the code.
    # Ptpython uses Pygments for code styling, so you can choose from Pygments'
    # color schemes. See:
    # https://pygments.org/docs/styles/
    # https://pygments.org/demo/
    # A colorscheme that looks good on dark backgrounds is 'native':
    repl.use_code_colorscheme('native')

    # Format
    repl.enable_output_formatting = True

    # Pager
    repl.enable_pager = True

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    # """
    # @repl.add_key_binding("c-e", "c-e")
    # def _(event):
    #     event.current_buffer.validate_and_handle()
    # """
