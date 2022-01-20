typedef AnswerCallBack = void Function(dynamic sdp, dynamic type);
typedef RemoteCandidateCallBack = void Function(
    dynamic candidate, dynamic sdpMid, dynamic sdpMLineIndex);

class VideoCallService {}
