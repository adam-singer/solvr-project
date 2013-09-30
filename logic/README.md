Business Logic
==============

Rules
-----

* Notes and Notebooks
 1.  Deletable notebooks are renamable
 2.  Deletable notebooks are sortable
 3.  Deletable notebooks are listed after non-deletable
 4.  Notebooks can only contain notes
 5.  Notebook list can only contain notebooks
 6.  Deleting a notebook removes all its notes (user is warned)
 7.  A note can only be in one deletable notebook 
 8.  Notes and Notebook names are not unique (they are identified by id).
 9.  Starred and scrapbook notebooks cannot be deleted
 10. Creating a note/notebook makes it active
 11. Notebooks can be sorted, notes are sorted by last used (ui like instapaper on iPad)
 12. Deleting a note, goes to the notebook it was in
 13. Dleteing a notebook, goes to scrapbook
 14. Going to a note/notebook, sets the last used resource to this
 
 // TODO
 - Deleteing a note removes its history permantly
 - Restoring a note does not affect history (i.e. make it active)
 - Notes have history (such as last used - think eclipse file history (back/forward)).
 - History is created when a note is selected or created