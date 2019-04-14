var utils = function () {
    return {
        query: function (url) {
            var params = {};
            var parser = document.createElement('a');
            parser.href = url;
            var query = parser.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('='),
                    param = decodeURIComponent(pair[0]),
                    value = decodeURIComponent(pair[1]);
                if (param.match(/.+\[]$/)) {
                    param = param.substring(0, param.length - 2);
                    params[param] || (params[param] = []);
                    params[param].push(value);
                } else {
                    params[param] = value;
                }
            }
            return params;
        }
    };
}();