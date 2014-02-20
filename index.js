var is = require('matthewp-is');
var properties = require('wryk-properties');

module.exports = Set;


function indexOf (element) {
	for (var i = this.length; i-- && !is(this[i], element);) {}
	return i;
}

function Set (iterable) {
	this._values = [];

	for (var i = -1, l = iterable.length; ++i < l;) {
		this.add(iterable[i]);
	}
}

Set.prototype.add = function (value) {
	var index = indexOf.call(this._values, value);
	if (index > -1) {
		this._values[index] = value;
	} else {
		this._values.push(value);
	}
};

Set.prototype.delete = function (value) {
	var index = indexOf.call(this._values, value);
	if (index > -1) {
		this._values.splice(index, 1);
		return true;
	}

	return false;
};

Set.prototype.has = function (value) {
	return indexOf.call(this._values, value) > -1 ? true : false;
};

Set.prototype.clear = function () {
	this._values.splice(0);
};

Set.prototype.forEach = function (callback, context) {
	for (var i = -1, l = this._values.length; ++i < l;) {
		callback.call(context, this._values[i], this);
	}
};

Set.prototype.values = Set.prototype.__iterator__ = function () {
	return new SetIterator(this);
};

properties(Set.prototype)
	.default({ configurable: true })
	.property('add').value().define()
	.property('remove').value().define()
	.property('has').value().define()
	.property('clear').value().define()
	.property('forEach').value().define()
	.property('values').value().define()
	.property('__iterator__').value().define()
	.property('size')
		.getter(function () {
			return this._values.length;
		}).define()
;



function SetIterator (set) {
	this._index = 0;
	this._values = set._values;
}

SetIterator.prototype.next = function () {
	var value = this._values[this._index++];
	return value !== undefined ? value : null;
};

properties(SetIterator.prototype)
	.default({ configurable: true })
	.property('next').value().define()
;