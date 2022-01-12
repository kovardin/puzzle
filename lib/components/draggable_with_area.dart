import 'package:flutter/cupertino.dart';

class DraggableWithArea<T extends Object> extends Draggable {
  const DraggableWithArea({
    Key? key,
    required this.child,
    required this.feedback,
    this.data,
    this.axis,
    this.childWhenDragging,
    this.feedbackOffset = Offset.zero,
    this.dragAnchorStrategy,
    this.affinity,
    this.maxSimultaneousDrags,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDraggableCanceled,
    this.onDragEnd,
    this.onDragCompleted,
    this.ignoringFeedbackSemantics = true,
    this.rootOverlay = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
  })  : assert(child != null),
        assert(feedback != null),
        assert(ignoringFeedbackSemantics != null),
        assert(maxSimultaneousDrags == null || maxSimultaneousDrags >= 0),
        super(
          key: key,
          child: child,
          feedback: feedback,
          data: data,
          axis: axis,
          childWhenDragging: childWhenDragging,
          feedbackOffset: feedbackOffset,
          dragAnchorStrategy: dragAnchorStrategy,
          affinity: affinity,
          onDragStarted: onDragStarted,
          onDragUpdate: onDragUpdate,
          onDragEnd: onDragEnd,
          onDragCompleted: onDragCompleted,
          rootOverlay: rootOverlay,
          hitTestBehavior: hitTestBehavior,
        );

  final T? data;
  final Axis? axis;
  final Widget child;
  final Widget? childWhenDragging;
  final Widget feedback;
  final Offset feedbackOffset;
  final DragAnchorStrategy? dragAnchorStrategy;
  final bool ignoringFeedbackSemantics;
  final Axis? affinity;
  final int? maxSimultaneousDrags;
  final VoidCallback? onDragStarted;
  final DragUpdateCallback? onDragUpdate;
  final DraggableCanceledCallback? onDraggableCanceled;
  final VoidCallback? onDragCompleted;
  final DragEndCallback? onDragEnd;
  final bool rootOverlay;
  final HitTestBehavior hitTestBehavior;
}
