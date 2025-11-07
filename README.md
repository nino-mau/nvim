# LAZYVIM CONFIG

## Shortcuts

- **Wrap selected lines with two different values**:

  ```bash
  S → i → input1:"content" input2:"content2"
  ```

- **Wrap selected lines with html tag**:

  ```bash
  S → t → "htmltag"
  ```

- **Open window with cursor-relevant message:**

  ```bash
  Ctrl + W → d
  ```

- **Go inside line string in edit mode**(useful to go inside html element class):

  ```bash
  f → " → a
  ```

- **Change the tag of html element**:

  ```bash
  c → s → t → input:"tagname"
  ```

## Commands

- **List information on all available LSPs:**

  ```bash
  :help lspconfig-all
  ```

- **Manage Treesitter installations:**

  ```bash
  :TSInstallInfo
  ```

- **Indent selection by one space:**

  ```bash
  :normal! I
  ```

- **Delete all matching patterns:**

  ```bash
  :%s/pattern/
  ```
