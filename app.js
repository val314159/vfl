function fetchPut (url, body) {return fetch(url, {method: 'PUT', body: body});}
function recurse  (f)         {return f.apply(f, Array.from(arguments));}
function GEBI     (x)         {return document.getElementById(x);}
function repr     (x)         {return JSON.stringify(x);}
function setText  (e, t)      {return ((e.innerText = t), e);}

class Application {
    launch () {
	var _ = this;

	function updateOutput  (v){ setText(_.output,   v) }

	function updateFile (k, v){ setText(_.filename, k).focus();
				    setText(_.content,  v) }

	function keypress () {
	    if(event.ctrlKey)
		switch(event.key[0]){
		case 'j':
		    console.log("JS RUN");
		    eval(_.content.innerText);
		    event.preventDefault();
		    return false;
		case 'r':
		    console.log("RUN");
		    runIt();
		    event.preventDefault();
		    return false;
		case 's':
		    console.log("SAVE");
		    uploadFile();
		    event.preventDefault();
		    return false;}}

	function install (){
	    _.dirList   = GEBI("dirList" );
	    _.filename  = GEBI("filename");
	    _.content   = GEBI("content" );
	    _.output    = GEBI("output"  );

	    GEBI("buttonNewFile"   ).onclick = newFile;
	    GEBI("buttonLoadFile"  ).onclick = loadFile;
	    GEBI("buttonUploadFile").onclick = uploadFile;

	    document.body.onkeypress = keypress;

	    document.body.onload = recurse(f=>{
		refreshDirList();
		setTimeout(f, 15000); });

	    downloadPlugins()}

	async function refreshDirList (){
	    var resp = await fetch("/ls-la");
	    var json = await resp.json();
	    _.dirList.innerHTML = "";
	    for(var x = 1; x < json.length; x++){
		var e = document.createElement("button");
		e.innerHTML = json[x].substr(2);
		e.onclick = (async (name)=> {
		    var resp = await fetch("/d/" + name);
		    var text = await resp.text();
		    updateFile(name, text);
		}).bind(null, json[x].substr(2));
		_.dirList.appendChild(e)}}

	async function newFile (){
	    updateFile("", "")}

	async function loadFile (){
	    var name = _.filename.innerText;
	    var url  = "/d/" + name;
	    var resp = await fetch(url);
	    var text = await resp.text();
	    updateFile(name, text)}

	async function uploadFile (){
	    var name = _.filename.innerText;
	    var url  = "/u/" + name;
	    var text = _.content.innerText;
	    var resp = await fetchPut(url, text);
	    var json = await resp.json();
	    console.log(JSON.stringify(json));
	    refreshDirList()}

	async function downloadPlugins (){
	    var resp = await fetch("/d/plugins.js");
	    if        (await resp.ok)
		eval(  await resp.text()  )}

	async function runIt (){
	    var name = _.filename.innerText;
	    var url  = "/d/" + name + ".out";
	    var resp = await fetch(url);
	    var text = await resp.text();
	    _.output.innerText = text}

	install()}}
