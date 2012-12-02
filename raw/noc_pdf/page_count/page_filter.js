function rewriteIndex()
{
    Log.info("!!!!!!!!! Runnning page filter");

    var div = document.getElementById("index");

    var lis = div.getElementsByTagName("li");

    for (var i = 0; i < lis.length; ++i)
    {
        var li = lis[i];
        removeDuplicates(li);
    }
}

function removeDuplicates(li)
{
    var index_term_name = children_of_type_and_class(li, "span", "index-term-name")[0];
    if(!index_term_name)  return;

    Log.info("---> Checking for indexterm: " + index_term_name.innerHTML);

    var text = "";
    var lastPage;
    var delete_indexes = [];

    var links = children_of_type_and_class(li, "span", "index-link");

    // find elements
    for (var i = 0; i < links.length; ++i)
    {
        var link = children_of_type_and_class(links[i], "a", "index-term-link")[0];
        var href = link.getAttribute("href");
        var page = refs[href];

        Log.info("Comparing Page " + page + " to last page " + lastPage);
        if(page == lastPage)
        {
          //Log.info("SHOULD DELETE: " + links[i].innerHTML);
          //Log.info("Duplicate!!!");
          delete_indexes.push(i);
        }

        lastPage = page;
    }

    //Log.info("INDEXES TO DELETE " + delete_indexes.toString());

    // delete the elements
    for(var i = links.length - 1; i >= 0; i--)
    {
        //Log.info("I IS: " + i);
        if(delete_indexes.indexOf(i) > -1)
        {
            var link = links[i];

            //Log.info("Deleting " + link.innerHTML);
            // delete container of link
            link.parentNode.removeChild(link);
        }
    }
}

/* Get Children With Class Name
---------------------------------------------------------------------- */

function children_of_type_and_class(n, nodeName, className)
{
    var selected = [];

    for(var i = 0; i < n.childNodes.length; i++)
    {
        var child = n.childNodes[i];

        if(child.nodeName == nodeName && child.className == className)
        {
            selected.push(child);
        }
    }
    return selected;
}


/* Get Previous Sibling Without Text Nodes
---------------------------------------------------------------------- */

function get_previoussibling(n)
{
  var x = n.previousSibling;

  if(x)
  {
    while (x.nodeType != 1)
    {
      x = x.previousSibling;
    }
  }
  return x;
}

addEventListener("load", rewriteIndex, false);