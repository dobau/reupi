(function() {
        var tree = $("#tree");

        var user = "dobau";
        var repo = "reupi";
        
        var dobau = gh.user(user);
        var reupi = gh.repo(user, repo);
        var obj = gh.object(user, repo);
        
        var shaParents = [];
        
        reupi.branches(function(response) {	
                tree.empty();
        
                if (response && response.branches && response.branches.master) {
                        showTree(response.branches.master);
                } else {
                        showError("Erro ao carregar informaç?es do github!");
                }
        });
        
        function configureClickInRow(row, file, shaParent) {
                if (file.type == "tree") {
                        row.click(function() {
                                shaParents.push(shaParent);
                                showTree(file.sha);
                        });
                } else if (file.type == "blob") {
                        row.click(function() {
                                shaParents.push(shaParent);
                                showBlob(file.name, shaParent);
                        });                        
                }
        }
        
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
        
        function showBlob(path, shaParent) {
                clearAndShowBack();
                obj.blob(path, shaParent, function(response) {
                        if (response.blob) {
                                tree.append($("<tr>")
                                                .append($("<td colspan='2'>")
                                                        .append("<b>"+path+"</b><br>")
                                                        .append($("<pre class='highlight'>")
                                                                        .append(response.blob.data))));
								$.SyntaxHighlighter.init();
                        } else {
                                showError("Erro ao carregar arquivo "+path);
                        }
                });
        }
        
        function showTree(sha) {
                clearAndShowBack();
                obj.tree(sha, function(response) {
                        if (response.tree) {
                                $.each(response.tree, function(index, file) {
                                        var type;
                                        
                                        if (file.type == "tree") {
                                                type = $("<i>").addClass("icon-folder-open");
                                        } else if (file.type == "blob") {
                                                type = $("<i>").addClass("icon-file");
                                        }
                                
                                        var row = $("<tr class='row-file'>")
                                                        .append($("<td class='type'>").append(type))
                                                        .append($("<td class='name'>").text(file.name));
                                                        //.append($("td").text(file.description));
                                        
                                        configureClickInRow(row, file, sha);
                                        
                                        tree.append(row);
                                });
                        } else {
                                showError("Erro ao carregar pasta");
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