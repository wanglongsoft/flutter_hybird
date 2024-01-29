import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef TextExpandedCallback = Function(bool);

///当文案过长时，可以设置展开和收起的组件
class ExpandableText extends StatefulWidget {
  ///显示的文本
  final String text;

  /// 文本的样式
  final TextStyle? textStyle;

  ///展开功能按钮的文本
  final String? moreText;

  /// 展开功能按钮的文本的样式
  final TextStyle? moreTextStyle;

  ///收起功能按钮的文本
  final String? foldedText;

  /// 收起功能按钮的文本的样式
  final TextStyle? foldedTextStyle;

  ///显示的最多行数
  final int? maxLines;

  /// 展开或者收起的时候的回调
  final TextExpandedCallback? onExpanded;

  /// 更多按钮渐变色的初始色 默认白色
  final Color? color;

  const ExpandableText(
      {Key? key,
      required this.text,
      this.maxLines = 1000000,
      this.textStyle,
      this.moreText,
      this.moreTextStyle,
      this.foldedText,
      this.foldedTextStyle,
      this.onExpanded,
      this.color}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    TextStyle style = _defaultTextStyle();
    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(text: widget.text, style: style);
        final tp = TextPainter(
            text: span,
            maxLines: widget.maxLines,
            textDirection: TextDirection.ltr,
            ellipsis: 'EllipseText');
        tp.layout(maxWidth: size.maxWidth);
        if (tp.didExceedMaxLines) {
          if (_expanded) {
            return _expandedText(context, widget.text);
          } else {
            return _foldedText(context, widget.text);
          }
        } else {
          return _regularText(widget.text, style);
        }
      },
    );
  }

  Widget _foldedText(context, String text) {
    return Stack(
      children: <Widget>[
        Text(
          widget.text,
          style: _defaultTextStyle(),
          maxLines: widget.maxLines,
          overflow: TextOverflow.clip,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _clickExpandTextWidget(context),
        )
      ],
    );
  }

  Widget _clickExpandTextWidget(context) {
    Color btnColor = widget.color ?? Colors.white;

    Text tx = Text(
      widget.moreText ?? "更多",
      style: _defaultMoreTextStyle(),
    );
    Container cnt = Container(
      padding: const EdgeInsets.only(left: 22),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [btnColor.withAlpha(100), btnColor, btnColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: tx,
    );
    return GestureDetector(
      child: cnt,
      onTap: () {
        setState(() {
          _expanded = true;
          if (null != widget.onExpanded) {
            widget.onExpanded!(_expanded);
          }
        });
      },
    );
  }

  Widget _expandedText(context, String text) {
    return RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        text: TextSpan(text: text, style: _defaultTextStyle(), children: [
          _foldButtonSpan(context),
        ]));
  }

  Widget _regularText(text, style) {
    return Text(text, style: style);
  }

  InlineSpan _foldButtonSpan(context) {
    return TextSpan(
        text: widget.foldedText ?? "收起",
        style: _defaultFoldedTextStyle(),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            setState(() {
              _expanded = false;
              if (null != widget.onExpanded) {
                widget.onExpanded!(_expanded);
              }
            });
          });
  }

  TextStyle _defaultTextStyle() {
    TextStyle style = widget.textStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        );
    return style;
  }

  TextStyle _defaultMoreTextStyle() {
    TextStyle style = widget.moreTextStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF0984F9),
        );
    return style;
  }

  TextStyle _defaultFoldedTextStyle() {
    TextStyle style = widget.foldedTextStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF0984F9),
        );
    return style;
  }
}
