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
    var text = "";
    var lastPage;

    var links = children_of_type(li, "a");//li.getElementsByTagName("a");

    for (var i = 0; i < links.length; ++i)
    {
        var link = links[i];
        var href = link.getAttribute("href");
        var page = refs[href];

        if(page == lastPage)
        {
            link.style.display = "none";

            // if there's a comma behind this, remove it
            var prevSibling = get_previoussibling(link);
            if(prevSibling && prevSibling.className == "comma")
            {
                prevSibling.style.display = "none";
            }
        }

        lastPage = page;
    }
}

/* Get Children With Class Name
---------------------------------------------------------------------- */

function children_of_type(n, nodeName)
{
    var classChildren = [];

    for(var i = 0; i < n.childNodes.length; i++)
    {
        var child = n.childNodes[i];

        if(child.nodeName == nodeName)
        {
            classChildren.push(child);
        }
    }
    return classChildren;
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