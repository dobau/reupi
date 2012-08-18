(function(window) {
        var tree = $("#tree");

        var dobau = new Gh3.User("dobau");
        var reupi = new Gh3.Repository("reupi", dobau);
        var shaParents = [];

        reupi.fetch(function() {
                reupi.fetchBranches(function() {
                        var master = reupi.getBranchByName("master");

                        
                        showTree(master);
                });
        });
        
        function clearAndShowBack() {
                tree.empty();
                if (shaParents.length != 0) {
                        showBack();
                }                
        }
        
        function showBack() {
                var name = $("<tr class='row-file'/>")
                                .append("<td class='type'><i class='icon-folder-open' /></td>")
                                .append("<td class='name'>..</td>");
                tree.append(name);
                name.click(function() {
                        showTree(shaParents.pop());
                });
        }
        
        function showFile(file, parent) {
                clearAndShowBack();
                file.fetchContent(function(err, content) {
                        if (err) {
                                showError("Erro ao carregar arquivo "+file.path);
                        } else {
                                tree.append($("<tr>")
                                                .append($("<td colspan='2'>")
                                                        .append("<b>"+file.path+"</b><br>")
                                                        .append($("<pre class='highlight'>")
                                                                        .append(content.getRawContent()))));
                                                                $.SyntaxHighlighter.init();

                        }
                });
        }
        
        function showTree(master) {
                clearAndShowBack();

                master.fetchContents(function(err, response) {
                        if (err) {
                                showError("Erro ao carregar informações do github!");
                        } else {
                                master.eachContent(function(content){
                                        var type = (content.type == "dir")?"icon-folder-open":"icon-file";
                                        var row = $("<tr class='row-file'>")
                                                        .append($("<td class='type'>").append($("<i>").addClass(type)))
                                                        .append($("<td class='name'>").text(content.name));
                                                        //.append($("td").text(file.description));
                                        
                                        if (content.type == "dir") {
                                                row.click(function() {
                                                        shaParents.push(response);
                                                        showTree(content);
                                                });
                                        } else if (content.type == "file") {
                                                row.click(function() {
                                                        shaParents.push(response);
                                                        showFile(content, master);
                                                });                        
                                        }
                                        
                                        tree.append(row);
                                });
                        }
                });
        }
        
        function showError(msg) {
                tree.children().remove();
                tree.text(msg);
                tree.css({color: "red"});
        }
        
})();

// geral  
$(function() {
	$.SyntaxHighlighter.init({
		'wrapLines': true,
		'lineNumbers': false
	});
});