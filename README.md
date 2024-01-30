# ImgurToAO3
Convert the HTML markup of your [Imgur](https://imgur.com/) posts into a format that works on [Archive Of Our Own](https://archiveofourown.org/). 

Ideal for comics and other sequential, visual works.

1. Sign in to imgur and edit the post you want to transfer.
   - You must be editing a post you own, or else there aren't distinguishing markers between the posts's content and the other miscellaneous images on the page.
1. ***Inspect*** the page and copy the markup inside the `html` tag
   - Since imgur loads in a bunch of stuff with javascript after the page initially loads, viewing the full page source normally doesn't work.
1. Save the markup to a new html file.
1. Run the script, passing the html file to the `SourcePath` parameter.
1. If you have re-used images to come before or after the content of the post, (like a title card or credit screen) paste their URLs into text files, each on a new line. 
   - Pass these files to the `$ImagesBeforePath` and `$ImagesAfterPath` parameters respectively.
1. Pass the name of the file you want to generate to the `OutputFileName` parameter.
