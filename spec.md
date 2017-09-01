# Specifications for the CLI Assessment

Specs:
- [X] Have a CLI for interfacing with the application - The program begins scraping automatically, than prompts the user with a list of books, each of which the user can use CLI to select and get more information about
- [X] Pull data from an external source - reddit is scraped for a list of books that currently have available deals, then the goodreads page for each of those books is scraped to get detailed information
- [X] Implement both list and detail views - The list is of the ~25 books (occasional weird reddit topics will produce cases the scraper will ignore) posted on reddit, and the books have individual details pages
