angular.module('loomioApp').directive 'joinGroupButton', ->
  scope: {group: '=', block: '=?'}
  restrict: 'E'
  templateUrl: 'generated/components/group_page/join_group_button/join_group_button.html'
  replace: true
  controller: ($rootScope, $scope, $window, AbilityService, ModalService, Session, Records, FlashService, MembershipRequestForm) ->
    Records.membershipRequests.fetchMyPendingByGroup($scope.group.key)

    $scope.isMember = ->
      Session.user().membershipFor($scope.group)?

    $scope.canJoinGroup = ->
      AbilityService.canJoinGroup($scope.group)

    $scope.canRequestMembership = ->
      AbilityService.canRequestMembership($scope.group)

    $scope.hasRequestedMembership = ->
      $scope.group.hasPendingMembershipRequestFrom(Session.user())

    $scope.askToJoinText = ->
      if $scope.hasRequestedMembership()
        'join_group_button.membership_requested'
      else
        'join_group_button.ask_to_join_group'

    $scope.joinGroup = ->
      if AbilityService.isLoggedIn()
        Records.memberships.joinGroup($scope.group).then ->
          $rootScope.$broadcast('joinedGroup')
          FlashService.success('join_group_button.messages.joined_group', group: $scope.group.fullName)
      else
        $window.location = '/users/sign_up?group_key=' + $scope.group.key

    $scope.requestToJoinGroup = ->
      ModalService.open MembershipRequestForm, group: -> $scope.group

    $scope.isLoggedIn = ->
      AbilityService.isLoggedIn()
