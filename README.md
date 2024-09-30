# Emacs LaTeX Live Preview

A portable Emacs LaTeX setup featuring instant HTML preview and auto-refresh powered by LaTeXML.

## Features

- Automatic LaTeX to HTML conversion on save (using LaTeXML)
- Live preview within Emacs using the `eww` browser
- Seamless preview updates with each save
- Automatic installation of required Emacs packages 
- Maximized Emacs window on startup for focused editing

## Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/myOverleafPapers/emacs-latex-live-preview
   ```
2. **Copy Configuration:** Copy the `.dir-locals.el` file to the root directory of your LaTeX project.

## Usage

1. **Open `main.tex`:** Open the `main.tex` file of your LaTeX project in Emacs.
2. **Automatic Setup:** Emacs will automatically maximize, convert your LaTeX to HTML, and display a live preview in a split window.
3. **Real-time Updates:** As you write and save your LaTeX code, the preview will refresh automatically.

## Requirements

- Emacs 25.1 or later
- Internet connection (for initial package installation)
- LaTeXML installed on your system ([https://latexml.github.io/](https://latexml.github.io/)) and added to your PATH

## Customization

- **`.dir-locals.el`:**  Feel free to adjust the settings in this file to tailor the behavior to your liking.
- **LaTeXML Command:** The `latexmlmath` command is used by default for conversion. If your LaTeXML installation requires a different command, update the `refresh-latex-html-preview` function accordingly.

## License

This project is licensed under the WTFPL - see the [LICENSE](https://en.wikipedia.org/wiki/WTFPL) for details.

## Contributing

Contributions, issues, and feature requests are most welcome! 

## Acknowledgements

- The Emacs community
- AUCTeX, RefTeX, and other amazing Emacs packages
- The LaTeXML developers

Enjoy an enhanced LaTeX writing experience!